#!/bin/bash

npm install --save-dev --no-package-lock @babel/cli @babel/core @babel/preset-env @babel/preset-react @babel/plugin-proposal-class-properties

if [ -z "$INPUT_TYPENAME" ]
then
    INPUT_TYPENAME="release"
fi

if [ -z "$INPUT_DIRECTORY" ]
then
    INPUT_DIRECTORY="./"
fi

workspace="/github/workspace";
babel_workspace="$workspace/node_modules/@babel";

transpile_file(){
    directory=$1
    if [[ "$directory" != *"${INPUT_TYPENAME}."* ]];
    then
        basename=$(basename $directory);
        extension="${basename##*.}"
        filename="${basename%.*}"
        if [ -z "$INPUT_OUTPUT" ];
        then
            output="${directory%/*}/"
        else
            mkdir -p $INPUT_OUTPUT
            output="$INPUT_OUTPUT";
        fi
        output_path="${output}${filename}.${INPUT_TYPENAME}.${extension}"
        rm ${output_path}
        $(npx babel ${directory} --out-file ${output_path} --presets "$babel_workspace/preset-env","$babel_workspace/preset-react" --plugins "$babel_workspace/plugin-proposal-class-properties")
        echo "COMPILE ${directory} | OUTPUT ${output_path}"
    fi
}

find "$INPUT_DIRECTORY" -type f -iname '*.js' -not -path "*/node_modules/*" | while read fname
do
    transpile_file $fname;
done

$(rm -r "$workspace/node_modules")