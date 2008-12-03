#!/usr/bin/perl
use FileHandle;
use strict;

# constants section:
my ($GENRE_FILE,$GENRE_HEADER_LENGTH) = ("genres.list", 376);
my $RATINGS_FILE = 'ratings.list';
my $RATINGS_HEADER_LINE = 
	qr/^New \s+ Distribution \s+ Votes \s+ Rank \s+ Title/xo;
my ($DIRECTORS_FILE , $DIRECTORS_HEADER_LENGTH)= ("directors.list",235);
my ($ACTORS_FILE,$ACTORS_HL) = ("actors.list",239);
my ($ACTRESSES_FILE,$ACTRESSES_HL) = ("actresses.list",240);


# main:
use Data::Dumper;
print STDERR "Getting genres...";

my $genref = get_genre_hash();
printf STDERR "found %d genred 'movies'\n", scalar keys %$genref;
print STDERR "Getting movies...";
my @movielist = get_top_250();
printf STDERR "found %d movies in top 250\n", scalar @movielist;
my (%used_genres, %movielist);
foreach my $tuple (@movielist) {
	my $name = $tuple->[0];
	my $genres = $genref->{$name};# or warn "No dice for $name\n";
	$used_genres{$_}++ for @$genres;
	$movielist{$name} = $tuple;
#	print "$name @$genres\n";
	push @$tuple, $genres;
}

my @genre_keys = sort grep {$used_genres{$_} > 1} keys %used_genres;
foreach my $movie (@movielist) {
	dump_movie($movie,\@genre_keys);
}

#print Dumper \%used_genres;
my @director_pairs = get_directors(\%movielist);
#print Dumper \@director_pairs;
foreach my $dirtuple (@director_pairs) { dump_person( "director", $dirtuple ) }
my @actor_pairs = get_actors(\%movielist);
#print Dumper $ref;
foreach (@actor_pairs) { dump_person ("actor", $_ ) }

sub get_genre_hash {
#return {}; # XXX TEMP
	print STDERR "Opening '$GENRE_FILE', skipping first [$GENRE_HEADER_LENGTH] lines\n";
	my %genres;
	open my $fh, "<$GENRE_FILE";
	while (<$fh>) {
		next if 1..$GENRE_HEADER_LENGTH;
		my($title,$genre) = /^(.*?)\s+(\S+)\s*$/;
		next unless $title && $genre;
		push @{$genres{$title} ||= []}, $genre;
	}
	return \%genres
}

sub get_top_250 {
	open my $fh, "<$RATINGS_FILE";
	my @movies;
	while (<$fh>) {
		next if 1 .. $_ =~ $RATINGS_HEADER_LINE;
		last if /^\s*$/;
		my ($blank,$meta,$votecount, $rating,$name, $year) =
			/^ 	(.{6}) # the always-empty "new" field
				(\d+) \s+ # information about how this was rated (we don't care)
				(\d+) \s+ # how many votes were cast on this one (possibly interesting)
				(\d\.\d) \s+  # the ranking (we almost certainly care!)
				(.* 			 # the movie name
					\((\d{4}) 	 # which includes (and ends with) the year
					  (?:\/I)?	 # which may have a little garbage after it 
					\)  		 # (special case for "Crash")
				)
				# here is where we would ignore or filter for epsiode information, 
				# if we cared about episode information
			/xo;
		if ($name) {
			push @movies, [$name,$year,$rating,$votecount];
		} else {
			warn "Anomaly found on line $. of input\n";
		}
	}
	return @movies;
}

sub get_directors {
	print STDERR "Getting directors... ";
	get_people($DIRECTORS_FILE,$DIRECTORS_HEADER_LENGTH,@_);
}

sub get_actors {
	my $movielist = shift;
	my $re = qr/
		\s*
		(\S.*  # main fragment of name
			\(\d{4} # year
			(?:\/\w+)? # junk for Crash and the like
			\)
			(?:	# optional episode information:
				\s+
				\{[^}]+\}
			)? 	
		) # this ends the name capture
		(?:		# optional role information
			\s+	\[
				([^]]+) # role
				\]
		)?
		(?:	\s+ <(\d+)> )? # optional number-of-billing information
	/x;
	print STDERR "Getting actors...";
	my @tuples = get_people($ACTORS_FILE,$ACTORS_HL,$movielist,$re);
	print STDERR "Getting actresses...";
	my @othertuples = get_people($ACTRESSES_FILE,$ACTRESSES_HL,$movielist,$re);
	return (@tuples,@othertuples);
}

sub get_people {
	my ($file,$headlen,$movielist, $re) = @_;
	$re ||= qr/(\S.*\S)/;
	my @tuples;
	open my $fh, "<$file";
	my $current_person;
		while (<$fh>) {
		next if $. <= $headlen;
		next unless /\S/;
		my ($movie,@rest);
		if (/^\S/) {
			($current_person) = /([^\t]+)\t+/;
			($movie, @rest) = $' =~ $re;
		} else {
			($movie, @rest) = $_ =~ $re;
		}
		if (exists $movielist{$movie}) {
			push @tuples, [$current_person,$movie,@rest];
		}
	}
	printf STDERR "Got %d tuples from %s...", scalar @tuples, $file;
	@tuples = filter_tuples(@tuples);
	printf STDERR "filtered to %d\n", scalar @tuples;
	return @tuples;
}

sub filter_tuples {
	# two pass filter, to simplify my life
	my %counts;
	foreach my $tuple (@_) {
		$counts{$tuple->[0]}++;
	}
	grep { $counts{$_->[0]} > 1 } @_;
}


sub dump_movie {
	my $movie = shift;
	my @keys = @{+shift};
	my ($name,$year,$rating,$votecount,$genres) = @$movie;
	my %genre_lookup = map { ($_,1) } @$genres;
	my $format = '(movie "%s" %d %f' . ' (%s %d)' x @keys . ")\n";
	printf $format, quotemeta($name), $year, $rating, 
		map { ($_, $genre_lookup{$_} || 0) } @keys;
}

sub dump_person {
	my ($tag,$tuple) = @_;
	print "(", 
		join( " ", $tag, map { $_ ? sprintf('"%s"',quotemeta) : 'NIL' } @$tuple), 
		")\n";
}