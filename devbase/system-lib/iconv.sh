#!/bin/bash
#https://www.gnu.org/software/libiconv/
#https://www.php.net/manual/zh/iconv.installation.php

Install_Libiconv() {
    if [ ! -e "${libiconv_install_dir}/lib/libiconv.la" ]; then
        pushd ${ubdevenv_dir}/src/devbase/php > /dev/null
        tar xzf libiconv-${libiconv_ver}.tar.gz
        pushd libiconv-${libiconv_ver} > /dev/null
        ./configure
        make -j ${THREAD} && make install
        popd > /dev/null
        rm -rf libiconv-${libiconv_ver}
        popd > /dev/null
    fi
}

Uninstall_Libiconv() {
    pushd /usr/local/lib > /dev/null
    rm -fv libcharset.la libcharset.so.1.0.0 libcharset.so.1 libcharset.so libcharset.a libiconv.la libiconv.so.2.6.1 libiconv.so.2 libiconv.so
    popd > /dev/null

    pushd /usr/local/include > /dev/null
    rm -fv libcharset.h localcharset.h iconv.h
    popd > /dev/null

    pushd /usr/local/share/man/man3 > /dev/null
    rm -fv iconv.3 iconv_close.3 iconvctl.3 iconv_open.3 iconv_open_into.3
    popd > /dev/null

    pushd /usr/local/share/gettext/po > /dev/null 
    rm -fv remove-potcdate.sin quot.sed boldquot.sed en@quot.header en@boldquot.header insert-header.sin Rules-quot   Makevars.template
    popd > /dev/null

    rm -f /usr/local/share/man/man1/iconv.1 /usr/local/bin/iconv

    catalogs='af.gmo bg.gmo ca.gmo cs.gmo da.gmo de.gmo el.gmo eo.gmo es.gmo et.gmo fi.gmo fr.gmo ga.gmo gl.gmo hr.gmo hu.gmo id.gmo it.gmo ja.gmo lt.gmo nl.gmo pl.gmo pt_BR.gmo rm.gmo ro.gmo ru.gmo sk.gmo sl.gmo sq.gmo sr.gmo sv.gmo tr.gmo uk.gmo vi.gmo wa.gmo zh_CN.gmo zh_TW.gmo'
    for cat in $catalogs; do
        cat=`basename $cat`
        lang=`echo $cat | sed -e 's/\.gmo$//'`
        for lc in LC_MESSAGES ; do
            rm -f /usr/local/share/locale/$lang/$lc/libiconv.mo;
        done
    done
}
