#!/bin/bash
#
# apktool v2 need jre1.7
# AOSP 4.0-4.4 need JDK1.6
# AOSP L need OpenJDK1.7
#

function is_jdk6()
{
    java -version 2>&1 | grep OpenJDK > /dev/null
    [ $? == 0 ] && return 1

    java -version 2>&1 | head -n 1 | grep '^java .*[ "]1\.6\..*$' > /dev/null
    [ $? == 0 ] && return 0

    return 1
}

function is_jdk7()
{
    java -version 2>&1 | grep OpenJDK > /dev/null
    [ $? == 0 ] && return 1

    java -version 2>&1 | head -n 1 | grep '^java .*[ "]1\.7\..*$' > /dev/null
    [ $? == 0 ] && return 0

    return 1
}

function is_openjdk7()
{
    java -version 2>&1 | grep OpenJDK > /dev/null
    [ $? != 0 ] && return 1

    java -version 2>&1 | head -n 1 | grep '^java .*[ "]1\.7\..*$' > /dev/null
    [ $? == 0 ] && return 0

    return 1
}

function strip_path()
{
    [[ -n "${QROM_OPENJDK7_HOME}" ]] && PATH=${PATH//"${QROM_OPENJDK7_HOME}/bin:"/}
    [[ -n "${QROM_JDK7_HOME}" ]] && PATH=${PATH//"${QROM_JDK7_HOME}/bin:"/}
    [[ -n "${QROM_JDK6_HOME}" ]] && PATH=${PATH//"${QROM_JDK6_HOME}/bin:"/}
}

function setup_jdk7()
{
    strip_path

    if [[ -n "${QROM_OPENJDK7_HOME}" ]];then
        export PATH=${QROM_OPENJDK7_HOME}/bin:${PATH}
        export JAVA_HOME=${QROM_OPENJDK7_HOME}
    fi

    is_openjdk7

    if [[ $? != 0 && -n ${QROM_JDK7_HOME} ]];then
        export PATH=${QROM_JDK7_HOME}/bin:${PATH}
        export JAVA_HOME=${QROM_JDK7_HOME}
    fi
}

function setup_jdk6()
{
    strip_path

    if [[ -n "${QROM_JDK6_HOME}" ]];then
        export PATH=${QROM_JDK6_HOME}/bin:${PATH}
        export JAVA_HOME=${QROM_JDK6_HOME}
    fi
}


if [[ ${APKTOOL_JAR} == *apktool-2.* ]];then

    is_jdk7 || is_openjdk7
    if [[ $? != 0 ]];then
        echo 'apktool v2.* require jre 1.7'
        echo 'Current jre is not v1.7, auto setup...'
        setup_jdk7
    fi

else

    # apktool v1, jre 1.6 or 1.7 is ok
    is_jdk7 || is_openjdk7 || is_jdk6
    if [[ $? != 0 ]];then
        echo "Not jre, try to setup"
        setup_jdk7
        is_jdk7 || is_openjdk7
        if [[ $? != 0 ]];then
            setup_jdk6
        fi
    fi

fi

if [[ ${APKTOOL_JAR} == *apktool-2.* ]];then
    is_jdk7 || is_openjdk7
    if [[ $? != 0 ]];then
        echo 'JRE 1.7 not exist!'
    else
        echo 'JRE is ok!'
    fi
else
    is_jdk7 || is_openjdk7 || is_jdk6
    if [[ $? != 0 ]];then
        echo 'JRE not exist!'
    else
        echo 'JRE is ok!'
    fi
fi

