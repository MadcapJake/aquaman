set -g CMD_DURATION 0

# lime green: A5C261
# light gold: E8BF6A
# off red: DA4939
# lilac: B6B3EB
# blue: 6D9CBE
# dark-blue: 5F87D7

function aqua_fst; set_color -o E8BF6A; end
function aqua_snd; set_color -o A5C261; end
function aqua_trd; set_color -o DA4939; end
function aqua_fth; set_color -o 5F87D7; end
function aqua_dim; set_color -o 666; end
function aqua_off; set_color normal; end
function bc; command bc -l $argv; end

function fish_prompt
  set -l code $status

  set -l prompt (prompt_pwd)
  set -l base (basename "$prompt")

  printf (aqua_snd)"⟪ "(begin
    if test "$PWD" = "/"
      test $code -eq 0; and echo (aqua_fst)"/"(aqua_off); or echo (aqua_dim)"/"(aqua_off)
    else
      echo ""
    end
  end)(echo "$prompt" \
  | sed "s|~|"(begin
      test $code -eq 0; and echo (aqua_fst); or echo (aqua_trd)
    end)"🔱 "(aqua_off)"|g" \
  | sed "s|/|"(aqua_snd)" ⟫ "(aqua_fth)"|g" \
  | sed "s|"$base"|"(aqua_fst)$base(aqua_off)" |g")(aqua_snd)(begin
    test "$PWD" = "$HOME"; and echo " "; echo ""
    end)(begin
      if test "$PWD" = "/"
        echo ""
      else
        echo "⟫ "
      end
    end)(aqua_off)
end
