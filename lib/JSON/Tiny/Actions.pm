class JSON::Tiny::Actions;

method TOP($/) {
    make $/.hash.values.[0].ast;
};
method object($/) {
    make $<pairlist>.ast.hash ;
}

method pairlist($/) {
    make $<pair>>>.ast;
}

method pair($/) {
    make $<string>.ast => $<value>.ast;
}

method array($/) {
    make [$<value>>>.ast];
}

method string($/) {
    my $s = '';
    for $/.caps {
        $s ~= .value.ast;
    }
    make $s;
}
method value:sym<number>($/) { make eval $/.Str }
method value:sym<string>($/) { make $<string>.ast }
method value:sym<true>($/)   { make Bool::True  }
method value:sym<false>($/)  { make Bool::False }
method value:sym<null>($/)   { make Any }
method value:sym<object>($/) { make $<object>.ast }
method value:sym<array>($/)  { make $<array>.ast }

method str($/)               { make ~$/ }

method str_escape($/) {
    if $<xdigit> {
        make chr(:16($<xdigit>.join));
    } else {
        given ~$/ {
            when '\\' { make '\\'; }
            when 'n'  { make "\n"; }
            when 't'  { make "\t"; }
            when 'f'  { make "\f"; }
            when 'r'  { make "\r"; }
        }
    }
}


# vim: ft=perl6
