class FoodChain
    @@animal_lyrics = [
       {fly: "I don't know why she swallowed the fly.\n"},
       {spider: "wriggled and jiggled and tickled inside her.\n"},
       {bird: "How absurd to swallow a bird!\n"},
       {cat: "Imagine that, to swallow a cat!\n"},
       {dog: "What a hog, to swallow a dog!\n"},
       {goat: "Just opened her throat and swallowed a goat!\n"},
       {cow: "I don't know how she swallowed a cow!\n"},
       {horse: "She's dead, of course!\n"}
    ]

    def self.song
        verses = @@animal_lyrics.map.with_index do |(animal, rhyme), i|
            
        end
    end

    private

    def self.old_lady_lyric(animal)
        "I know an old lady who swallowed a #{animal}."
    end

    def self.swallowed_lyric(predator, prey)
        "She swallowed the #{predator} to catch the #{prey}"
    end
end