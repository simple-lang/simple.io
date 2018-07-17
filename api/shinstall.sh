#
#
#
#
#
#
#
#
# curl -sSfL https://simple-lang.io/api/stable_version.sim to get version by url in future

setup_url_prefix="http://10.0.2.2/simple-lang/"
temp_dir="${TMPDIR:-/tmp}"
simple_lang_version="s0.3.36"
need_tty=yes

install_simple_lang() {
	get_os_platform || return 1
	local os_platform=$return_value
	if [ $simple_lang_version = "not_supported_yet" ]; then 
		display_error your 
	fi
	local setup_file_name="$os_platform"_"$simple_lang_version"
	echo $setup_file_name
}

display() {
	echo "simple-lang:install:script: $1"
}

display_error() {
	display "error: $1" >&2
}

get_os_platform() {
	  # Get OS/CPU info and store in a `myos` and `mycpu` variable.
	  local ucpu=`uname -m`
	  local uos=`uname`
	  local ucpu=`echo $ucpu | tr "[:upper:]" "[:lower:]"`
	  local uos=`echo $uos | tr "[:upper:]" "[:lower:]"`

	  case $uos in
		*linux* )
		  local myos="linux"
		  ;;
		*dragonfly* )
		  local myos="freebsd"
		  ;;
		*freebsd* )
		  local myos="freebsd"
		  ;;
		*openbsd* )
		  local myos="openbsd"
		  ;;
		*netbsd* )
		  local myos="netbsd"
		  ;;
		*darwin* )
		  local myos="macosx"
		  if [ "$HOSTTYPE" = "x86_64" ] ; then
			local ucpu="amd64"
		  fi
		  ;;
		*aix* )
		  local myos="aix"
		  ;;
		*solaris* | *sun* )
		  local myos="solaris"
		  ;;
		*haiku* )
		  local myos="haiku"
		  ;;
		*mingw* )
		  local myos="windows"
		  ;;
		*)
		  err "unknown operating system: $uos"
		  ;;
	  esac

	  case $ucpu in
		*i386* | *i486* | *i586* | *i686* | *bepc* | *i86pc* )
		  local mycpu="i386" ;;
		*amd*64* | *x86-64* | *x86_64* )
		  local mycpu="amd64" ;;
		*sparc*|*sun* )
		  local mycpu="sparc"
		  if [ "$(isainfo -b)" = "64" ]; then
			local mycpu="sparc64"
		  fi
		  ;;
		*ppc64* )
		  local mycpu="powerpc64" ;;
		*power*|*ppc* )
		  local mycpu="powerpc" ;;
		*mips* )
		  local mycpu="mips" ;;
		*arm*|*armv6l* )
		  local mycpu="arm" ;;
		*aarch64* )
		  local mycpu="arm64" ;;
		*)
		  err "unknown processor: $ucpu"
		  ;;
	  esac

	  return_value="$myos"_"$mycpu"
}

install_simple_lang