
from random import choice

if __name__ == "__main__":

    repetir = True

    while repetir:
        repetir_jogo = input("\nVamos jogar? sim/nao ")
        if repetir_jogo == "sim":
            
            print('''
                                                , \ 
                  _.----.        ____         ,'  _\   ___    ___     ____
              _,-'       `.     |    |  /`.   \,-'    |   \  /   |   |    \  |`.
              \      __    \    '-.  | /   `.  ___    |    \/    |   '-.   \ |  |
               \.    \ \   |  __  |  |/    ,','_  `.  |          | __  |    \|  |
                 \    \/   /,' _`.|      ,' / / / /   |          ,' _`.|     |  |
                  \     ,-'/  /   \    ,'   | \/ / ,`.|         /  /   \  |     |
                   \    \ |   \_/  |   `-.  \    `'  /|  |    ||   \_/  | |\    |
                    \    \ \      /       `-.`.___,-' |  |\  /| \      /  | |   |
                     \    \ `.__,'|  |`-._    `|      |__| \/ |  `.__,'|  | |   |
                      \_.-'       |__|    `-._ |              '-.|     '-.| |   |
                                                                            '-._|
                ''')

            print("--- JOGO DA FORCA ---\n")
            print("Tens 5 tentativas para apanhar um Pokemon da primeira geração.\n")

            pokemon = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
            "Squirtle", "Wartortle", "Blastoise","Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna",
            "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate", "Spearow", "Fearow", 
            "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran", "Nidorina", 
            "Nidoqueen", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales",
            "Jigglypuff", "Wigglytuff","Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect",
            "Venonat", "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey",
            "Primeape", "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra",
            "Alakazam", "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool",
            "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
            "Magnemite", "Magneton", "Farfetch", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
            "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby", "Kingler",
            "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan",
            "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan",
            "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx",
            "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee",
            "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar", "Kabuto", "Kabutops", "Aerodactyl",
            "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair", "Dragonite", "Mewtwo","Mew"]
            
            pokemon_secreto = choice(pokemon).lower()

            tentativa = ["_" for letra in pokemon_secreto]
            print(tentativa)
            
            cond = True
            num_tentativa_errada = 5
            letras_adivinhadas = []
            letras_erradas = []

            while cond:
                letra = input("\nInsira uma letra: ")
                count_certo = 0 
                for letra_pokemon in pokemon_secreto:
                    if letra == pokemon_secreto[pokemon_secreto.index(letra_pokemon)]:
                        if count_certo == 0:
                            tentativa[pokemon_secreto.index(letra_pokemon)] = pokemon_secreto[pokemon_secreto.index(letra_pokemon)]
                            letras_adivinhadas.append(letra)
                            count_certo += 1  
                        else:    
                            tentativa[pokemon_secreto.index(letra_pokemon, pokemon_secreto.index(letra_pokemon) + 1)] = pokemon_secreto[pokemon_secreto.index(letra_pokemon)]
                            count_certo += 1          
                if "_" not in tentativa:
                        print(f"Apanhaste o/a {pokemon_secreto}!\n")
                        print(''' 
                                             `;,;.;,;.;.'
                                              ..:;:;::;: 
                                        ..--''' '' ' ' '''--.  
                                      /' .   .'        '.   .`|
                                     | /    /            \   '.|
                                     | |   :             :    :|
                                   .'| |   :             :    :|
                                  ,: /\ \.._\ __..===..__/_../ /`.
                                 |'' |  :.|  `'          `'  |.'  ::.
                                 |   |  ''|    :'';          | ,  `''|
                                 |.:  \/  | /'-.`'   ':'.-'\ |  \,   |
                                 | '  /  /  | / |...   | \ |  |  |';'|
                                  \ _ |:.|  |_\_|`.'   |_/_|  |.:| _ |
                                 /,.,.|' \__       . .      __/ '|.,.,
                                      | ':`.`----._____.---'.'   |
                                        \   `:"""-------'""' |   |
                                       ',-,-',             .'-=,=,
                            ''')
                        cond = False
                if count_certo == 0:
                    letras_erradas.append(letra)
                    print(f"\nEssa letra não faz parte da palavra.\nRestam {num_tentativa_errada - 1} tentativas!\n")
                    num_tentativa_errada = num_tentativa_errada - 1
                    if num_tentativa_errada == 0:
                        print(f"Não conseguiste apanhar o/a {pokemon_secreto}!\n")
                        print('''
                                        .-. \_/ .-.
                                        \.-\/=\/.-/
                                     '-./___|=|___\.-'
                                    .--| \|/`"`\|/ |--.
                                   (((_)\  .---.  /(_)))
                                    `\ \_`-.   .-'_/ /`_
                                      '.__       __.'(_))
                                          /     \     //
                                         |       |__.'/
                                         \       /--'`
                                     .--,-' .--. '----.
                                    '----`--'  '--`----'
                            ''')
                        cond = False
                print(tentativa)
                print(f"\nLetras Adivinhadas: {letras_adivinhadas}")
                print(f"Letras Erradas: {letras_erradas}")

        else:
            repetir = False


    