// swift-format-ignore-file
public struct JaKNBCModel: Model {
    public init() {}
    public let supportedNaturalLanguages: Set = ["ja"]
    /// Default built-in model mapping a feature (str) and its score (int).
    public let featureAndScore: [String: Int] = ["UW3:\u{3001}": 3634, "UW3:\u{3002}": 4347, "UW4:\u{306e}": -2581, "UW4:\u{3001}": -4812, "UW3:\u{306e}": 2538, "UW4:\u{3002}": -4206, "UW3:\u{306b}": 2701, "UW5:\u{3002}": -1455, "UW4:\u{3066}": -2403, "UW3:\u{306f}": 2977, "UW4:\u{306b}": -2678, "UW3:\u{3092}": 4165, "UW5:\u{3001}": -818, "UW2:\u{3001}": -1011, "UW3:\u{304c}": 2996, "UW2:\u{3002}": -904, "UW4:\u{3067}": -1808, "UW3:\u{3068}": 2064, "UW4:\u{306f}": -2164, "UW4:\u{304c}": -2180, "UW4:\u{308b}": -2760, "UW4:\u{3063}": -2310, "UW3:\u{3082}": 2360, "UW5:\u{306a}": -388, "UW3:\u{3067}": 1842, "UW3:\u{308b}": 1706, "UW5:\u{3067}": -706, "UW4:\u{3092}": -2408, "UW4:\u{304b}": -1628, "UW3:\u{3063}": -1005, "UW2:\u{306e}": -434, "UW4:\u{3068}": -1442, "UW5:\u{3063}": 543, "UW4:\u{306a}": -1091, "UW3:\u{3066}": 1355, "UW4:\u{305f}": -1056, "UW4:\u{3053}": 258, "UW6:\u{306b}": 277, "UW4:\u{3089}": -2999, "UW3:\u{305f}": 1331, "UW2:\u{3092}": -1305, "UW3:\u{3089}": 1242, "UW6:\u{3002}": -337, "UW4:\u{3057}": -1073, "UW3:\u{306a}": 1392, "UW2:\u{306b}": -576, "UW4:\u{3044}": -886, "UW4:\u{308a}": -2405, "UW6:\u{3046}": -386, "UW3:\u{3046}": 1031, "UW3:\u{304f}": 1470, "UW4:\u{308c}": -2105, "UW2:\u{306f}": -594, "UW4:\u{3060}": -1461, "UW4:\u{3046}": -1160, "UW3:\u{3044}": 964, "UW6:\u{3044}": -48, "UW4:\u{3093}": -2158, "UW2:\u{304b}": 110, "UW4:\u{30fc}": -1750, "UW6:\u{3092}": 228, "UW2:\u{3082}": -603, "UW5:\u{304d}": 801, "UW3:\u{308a}": 972, "UW6:\u{3067}": 102, "UW2:\u{308b}": -395, "UW2:\u{3068}": -508, "UW3:\u{ff3d}": 1640, "UW4:\u{305d}": 191, "UW3:\u{ff0c}": 2468, "UW4:\u{3082}": -1580, "UW4:\u{304f}": -1529, "UW3:\u{304b}": 1148, "BW2:\u{3068}\u{3044}": 515, "UW4:\u{304a}": 539, "UW4:\u{307e}": -774, "UW6:\u{304c}": 111, "UW4:\u{304d}": -1275, "UW2:\u{3057}": 113, "UW2:\u{3066}": -432, "UW3:\u{ff01}": 1736, "UW2:\u{307e}": 588, "UW5:\u{306b}": -413, "UW3:\u{3084}": 1360, "UW6:\u{3066}": 49, "BW3:\u{3082}\u{306e}": 2322, "UW6:\u{306e}": 48, "UW2:\u{3093}": 255, "UW2:\u{304c}": -521, "UW5:\u{304c}": -366, "BW1:\u{3044}\u{3046}": 529, "UW2:\u{3067}": -493, "UW5:\u{3059}": -557, "UW3:\u{ff1f}": 1719, "UW5:\u{3068}": -476, "UW6:\u{306f}": 104, "UW3:\u{ff0e}": 1311, "UW4:\u{300c}": 1314, "UW3:\u{3070}": 1307, "UW5:\u{3093}": 520, "BW3:\u{3044}\u{3046}": 666, "UW4:\u{3059}": -412, "BW1:\u{304b}\u{3089}": 627, "UW3:\u{3069}": 1098, "UW5:\u{3057}": -209, "UW2:\u{3063}": 163, "UW4:\u{601d}": 955, "UW3:\u{2026}": 1798, "UW5:\u{308b}": -39, "BW2:\u{3066}\u{3044}": -753, "BW3:\u{3088}\u{3046}": -1262, "UW5:\u{3048}": 411, "UW4:\u{79c1}": 1247, "UW3:\u{30fb}": 914, "UW4:\u{4eba}": 522, "UW5:\u{304f}": 348, "UW3:\u{ff09}": 2156, "UW4:\u{4eac}": 510, "BW2:\u{306a}\u{3044}": -1522, "UW3:\u{30fc}": -243, "BW3:\u{3068}\u{3053}": 1337, "UW5:\u{306f}": -378, "UW4:\u{300d}": -1957, "UW2:\u{4e00}": 834, "UW4:\u{3088}": -450, "BW3:\u{3053}\u{3068}": 235, "UW5:\u{30fc}": 87, "UW6:\u{3057}": 236, "UW4:\u{3051}": -1615, "BW1:\u{306a}\u{3044}": 485, "BW2:\u{3067}\u{3059}": -1445, "UW4:\u{4e00}": 488, "UW5:\u{5e2f}": 404, "UW5:\u{3092}": -333, "UW6:\u{306a}": 66, "UW5:\u{3079}": 787, "BW3:\u{3044}\u{3044}": 647, "BW2:\u{3067}\u{3042}": -1495, "BW2:\u{306e}\u{3067}": -756, "UW4:\u{ff0c}": -1700, "UW5:\u{308c}": 279, "UW5:\u{308d}": -81, "UW1:\u{305d}": 260, "UW5:\u{3044}": 162, "UW1:\u{3044}": -51, "UW5:\u{30fb}": -851, "UW5:\u{308f}": 462, "UW4:\u{ff11}": 493, "UW5:\u{3046}": 161, "UW4:\u{5927}": 396, "UW3:\u{307e}": -238, "BW2:\u{3068}\u{3053}": -1044, "UW4:\u{ff01}": -1685, "UW4:\u{898b}": 433, "UW4:\u{884c}": 276, "BW1:\u{3053}\u{3068}": -695, "UW1:\u{306a}": -148, "UW2:\u{3055}": 416, "UW3:\u{2606}": 1235, "UW4:\u{3055}": -748, "UW2:\u{3088}": 257, "BW1:\u{3068}\u{304b}": 784, "UW4:\u{ff08}": 748, "BW3:\u{3067}\u{3082}": 767, "UW5:\u{306e}": -262, "UW4:\u{30fb}": -490, "UW5:\u{305f}": -26, "UW1:\u{3059}": 152, "UW5:\u{304b}": 186, "UW4:\u{4f7f}": 544, "UW3:\u{266a}": 1035, "UW4:\u{3048}": -711, "UW4:\u{4eca}": 549, "BW2:\u{3001}\u{3068}": -517, "BW3:\u{3068}\u{304d}": 799, "UW4:\u{308d}": -1024, "UW5:\u{3064}": 542, "UW1:\u{306b}": -118, "UW5:\u{3058}": 432, "UW1:\u{3067}": -56, "UW4:\u{30f3}": -694, "UW3:\u{305a}": 668, "BW3:\u{3057}\u{3066}": 249, "UW4:\u{98df}": 175, "UW4:\u{6c17}": 329, "UW4:\u{6642}": 305, "UW3:\u{65e5}": 287, "BW1:\u{3057}\u{3044}": 423, "UW4:\u{81ea}": 438, "UW3:\u{7b11}": 934, "UW2:\u{6bce}": 628, "TW1:\u{3068}\u{3044}\u{3046}": 292, "UW4:\u{307f}": -536, "UW4:\u{2026}": -995, "TW2:\u{3067}\u{306f}\u{306a}": -814, "UW6:\u{3055}": 237, "UW5:\u{3081}": 263, "UW2:\u{5c11}": 571, "UW5:\u{3042}": -138, "UW4:\u{ff12}": 402, "UW3:\u{3078}": 701, "TW3:\u{3068}\u{3044}\u{3046}": 387, "UW4:\u{4f55}": 474, "UW2:\u{304f}": -183, "UW2:\u{7d50}": 661, "BW1:\u{3046}\u{306a}": 280, "BW1:\u{3082}\u{3046}": 767, "UW1:\u{304c}": -53, "UW4:\u{3058}": -793, "UW2:\u{3046}": -191, "UW4:\u{30eb}": -401, "UW3:\u{300d}": 526, "BW1:\u{3068}\u{304c}": -679, "UW2:\u{6700}": 279, "BW1:\u{308b}\u{306e}": -407, "UW3:\u{9593}": 493, "UW6:\u{305f}": -82, "UW3:\u{3064}": 365, "UW4:\u{3069}": -334, "UW1:\u{3068}": 36, "UW3:\u{3093}": 284, "UW4:\u{ff0e}": -813, "UW3:\u{3060}": 424, "UW4:\u{308f}": -425, "UW4:\u{6700}": 423, "UW4:\u{ff1f}": -796, "UW3:\u{308d}": 452, "UW4:\u{3070}": -635, "TW3:\u{3066}\u{3044}\u{308b}": -389, "BW3:\u{3053}\u{306e}": 404, "UW5:\u{3082}": -141, "UW3:\u{4eba}": 415, "BW3:\u{3068}\u{3044}": -277, "UW4:\u{3064}": -400, "BW3:\u{305d}\u{306e}": 502, "BW3:\u{3082}\u{3046}": 766, "UW2:\u{305d}": -182, "BW2:\u{306b}\u{306f}": -426, "BW3:\u{304b}\u{3051}": 720, "TW4:\u{306e}\u{4eac}\u{90fd}": 1005, "TW4:\u{3068}\u{3053}\u{308d}": 422, "UW3:\u{4eac}": -396, "UW4:\u{643a}": 123, "BW1:\u{304b}\u{3082}": -533, "BW1:\u{3067}\u{306f}": -91, "UW4:\u{3061}": -355, "UW3:\u{5206}": 333, "UW4:\u{3079}": -596, "BW3:\u{3053}\u{308d}": -333, "UW3:\u{3083}": 434, "UW2:\u{3059}": 31, "BW1:\u{3002}\u{30fb}": 567, "UW3:\u{96fb}": -356, "BW3:\u{306a}\u{3063}": -309, "UW3:\u{3059}": 251, "BW1:\u{6700}\u{8fd1}": 365, "UW4:\u{3081}": -399, "UW3:\u{3050}": 411, "UW2:\u{304a}": -235, "BW3:\u{305d}\u{3057}": -526, "BW1:\u{304b}\u{3057}": 468, "BW1:\u{540c}\u{3058}": 438, "BW3:\u{30e1}\u{30fc}": 136, "UW5:\u{3066}": 103, "UW6:\u{308a}": 74, "TW4:\u{304f}\u{3089}\u{3044}": 585, "UW3:\u{4eca}": 324, "UW5:\u{305d}": -115, "UW4:\u{3084}": -219, "UW5:\u{300d}": -217, "UW4:\u{5e2f}": -289, "UW6:\u{30fc}": -88, "BW2:\u{3068}\u{3057}": 143, "TW1:\u{3088}\u{3046}\u{306a}": 361, "BW2:\u{3066}\u{304a}": -558, "UW4:\u{7b11}": -614, "UW1:\u{306f}": -56, "BW3:\u{304b}\u{304b}": 456, "TW4:\u{304b}\u{306a}\u{308a}": 441, "UW4:\u{ff09}": -566, "BW1:\u{3093}\u{306a}": 102, "UW1:\u{3061}": 112, "TW2:\u{6c17}\u{306b}\u{5165}": -466, "TW1:\u{30fb}\u{30fb}\u{30fb}": 325, "UW6:\u{3068}": -27, "UW5:\u{3061}": 128, "BW3:\u{305f}\u{3081}": 294, "UW4:\u{305a}": -321, "UW3:\u{ff10}": -224, "BW1:\u{3093}\u{3067}": -206, "UW3:\u{4e2d}": 252, "UW3:\u{3005}": 209, "BW2:\u{306e}\u{3088}": -207, "BW2:\u{5e2f}\u{96fb}": -224, "BW2:\u{3067}\u{3082}": -207, "BW1:\u{306b}\u{306f}": 109, "BW3:\u{3061}\u{3087}": 316, "UW4:\u{305b}": -234, "UW3:\u{5ea6}": 222, "BW1:\u{3067}\u{3082}": 95, "BW1:\u{304c}\u{3001}": 192, "UW2:\u{306a}": -40, "UW5:\u{601d}": -98, "UW6:\u{ff10}": 82, "UW6:\u{5bfa}": 68, "BW3:\u{3068}\u{3066}": 230, "BW3:\u{3042}\u{308b}": -28, "BW2:\u{3082}\u{3057}": -67, "UW4:\u{30c3}": -149, "UW1:\u{3066}": 14, "BW2:\u{306b}\u{3082}": -120, "BW1:\u{308c}\u{305f}": 95, "UW4:\u{3072}": 122, "TW3:\u{308b}\u{3053}\u{3068}": -81, "BW1:\u{3066}\u{3044}": -67, "UW4:\u{300f}": -296, "BW1:\u{3060}\u{3051}": 122, "UW3:\u{304a}": -81, "BW1:\u{5c11}\u{3057}": 134, "TW3:\u{3001}\u{3042}\u{308b}": -200, "UW5:\u{ff01}": -67, "UW6:\u{30eb}": 14, "UW2:\u{591a}": 67, "UW6:\u{3054}": 119, "UW6:\u{3084}": 40, "UW3:\u{5f8c}": 118, "BW2:\u{3066}\u{307f}": -92, "BW1:\u{3068}\u{304d}": 91, "UW4:\u{3083}": -105, "BW1:\u{305f}\u{3044}": 53, "UW3:\u{304d}": 40, "TW4:\u{3053}\u{3068}\u{304c}": -51, "UW3:\u{771f}": 39, "BW2:\u{306a}\u{3069}": -64, "UW6:\u{3071}": 105, "BW1:\u{3063}\u{305f}": 13, "BW1:\u{3066}\u{3082}": 39, "UW5:\u{65e5}": 26, "BW1:\u{305f}\u{3068}": -52, "UW4:\u{ff3d}": -52, "UW3:\u{30c3}": -52, "TW4:\u{30e1}\u{30fc}\u{30eb}": 26, "BW2:\u{306f}\u{306a}": -26, "BW3:\u{30fb}\u{30fb}": -39, "BW3:\u{306a}\u{308b}": 13, "BW1:\u{3068}\u{3044}": -13, "UW2:\u{5168}": 39, "BW1:\u{306b}\u{3082}": 26, "BW1:\u{305f}\u{3089}": 13, "BW2:\u{304f}\u{306a}": -39, "UW3:\u{300c}": -26, "BW1:\u{305d}\u{306e}": -26, "UW3:\u{89b3}": -26, "BW1:\u{3046}\u{306b}": -13, "UW3:\u{30a4}": -13, "BW3:\u{3082}\u{3093}": 39, "UW5:\u{305a}": 26, "BW3:\u{3057}\u{307e}": -13, "BW1:\u{3088}\u{308a}": 26, "UW5:\u{5206}": 13]

}