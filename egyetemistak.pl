% A lista összes egyetemistájának kiírása rekurzívan
kiir([]). 
kiir([egyetemista(Vezeteknev, Keresztnev, Egyetem, Szak) | Tobbi]) :-
    format('~w ~w a(z) ~wi egyetemen ~w szakos hallgató.~n', [Vezeteknev, Keresztnev, Egyetem, Szak]),
    kiir(Tobbi).

% A fő predikátum: megoldja a feladatot
megold(Egyetemistak) :-
    Egyetemistak = [_, _, _, _, _],
    
    % ------------- PERMUTÁCIÓK: mindegyik attribútumból egyszer-egyszer fordulhat elő -------------------
    %permutation([egressy, fenyvesi, gallyas, jeney, vadkerti], [Vez1, Vez2, Vez3, Vez4, Vez5]),
    %permutation([edina, frida, gabriella, józsef, vince], [Ker1, Ker2, Ker3, Ker4, Ker5]),
    %permutation([budapest, debrecen, miskolc, pécs, szeged], [Egy1, Egy2, Egy3, Egy4, Egy5]),
    %permutation([biologia, informatika, jog, kemia, magyar], [Szak1, Szak2, Szak3, Szak4, Szak5]),
    
    %Azért, hogy a permutációkat ne kelljen használni:
    % ------------- TAGOK MEGHATÁROZÁSA -------------------
    % Vezetéknevek
    member(egyetemista(egressy, _, _, _), Egyetemistak),
    member(egyetemista(fenyvesi, _, _, _), Egyetemistak),
    member(egyetemista(gallyas, _, _, _), Egyetemistak),
    member(egyetemista(jeney, _, _, _), Egyetemistak),
    member(egyetemista(vadkerti, _, _, _), Egyetemistak),

    % Keresztnevek
    member(egyetemista(_, edina, _, _), Egyetemistak),
    member(egyetemista(_, frida, _, _), Egyetemistak),
    member(egyetemista(_, gabriella, _, _), Egyetemistak),
    member(egyetemista(_, józsef, _, _), Egyetemistak),
    member(egyetemista(_, vince, _, _), Egyetemistak),

    % Egyetemek
    member(egyetemista(_, _, budapest, _), Egyetemistak),
    member(egyetemista(_, _, debrecen, _), Egyetemistak),
    member(egyetemista(_, _, miskolc, _), Egyetemistak),
    member(egyetemista(_, _, pécs, _), Egyetemistak),
    member(egyetemista(_, _, szeged, _), Egyetemistak),

    % Szakok
    member(egyetemista(_, _, _, biologia), Egyetemistak),
    member(egyetemista(_, _, _, informatika), Egyetemistak),
    member(egyetemista(_, _, _, jog), Egyetemistak),
    member(egyetemista(_, _, _, kemia), Egyetemistak),
    member(egyetemista(_, _, _, magyar), Egyetemistak),

    % ------------------- FELTÉTELEK -------------------
    % 1. A Fenyvesi vezetéknevű lány jogot tanul, de nem Debrecenben.
    member(egyetemista(fenyvesi, KeresztnevF, EgyetemF, jog), Egyetemistak),
    EgyetemF \= debrecen,
    (
        KeresztnevF = edina
        ;
        KeresztnevF = frida
    	;
    	KeresztnevF = gabriella
    ),

    % 2. József (nem Gallyas) egyik fővárosi egyetemen tanul (azaz Budapest), de nem biológia szakon.
    member(egyetemista(VezJ, józsef, budapest, SzakJ), Egyetemistak),
    VezJ \= gallyas,
    SzakJ \= biologia,

    % 3. Vadkerti Gabriella nem a szegedi kémiaszakos hallgató.
    member(egyetemista(vadkerti, gabriella, EgyVG, SzakVG), Egyetemistak),
    (EgyVG \= szeged , SzakVG \= kemia),
    
    % 3.5. szabály: legyen valaki, aki szegedi kémiaszakos hallgató. 
    member(egyetemista(_, _, szeged, kemia), Egyetemistak),

    % 4. Jeney (ő Pécsett tanul) keresztneve nem Vince.
    member(egyetemista(jeney, KerJeney, pécs, _), Egyetemistak),
    KerJeney \= vince,

    % 5. Frida magyartanár szeretne lenni.
    member(egyetemista(_, frida, _, magyar), Egyetemistak),

    % 6. Edina vezetékneve vagy Egressy, vagy Miskolcon tanul.
    (
        member(egyetemista(egressy, edina, _, _), Egyetemistak)
        ;
        member(egyetemista(_, edina, miskolc, _), Egyetemistak)
    ),

    % 7. Az informatikus egyetemista nemrég nősült.
    member(egyetemista(_, KeresztnevI, _, informatika), Egyetemistak),
    (
        KeresztnevI = józsef
        ;
        KeresztnevI = vince
    ).

% Egy külön predikátum, hogy szépen kiírja a megoldást
megold_kiir :-
    once(megold(Egyetemistak)),
    kiir(Egyetemistak),
    writeln('Az egyetemisták listája:'),
    forall(member(E, Egyetemistak), (format('~w~n', [E]))).
