From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: "libtool: install: warning: remember to run `libtool --finish /usr/lib'
 "
Date: Tue, 08 Nov 2005 22:50:30 +0100
Message-ID: <43711DA6.6070900@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some warnings when building alsa-oss rc3.

$ grep arnin alsa-oss_1.0.9+1.0.10rc3-1~1_i386.build
libtool: link: warning: `/usr/lib/gcc/i486-linux-gnu/4.0.2/../../..//libasound.la' seems to be moved
libtool: install: warning: remember to run `libtool --finish /usr/lib'
libtool: install: warning: relinking `libaoss.la'
libtool: link: warning: `/usr/lib/gcc/i486-linux-gnu/4.0.2/../../..//libasound.la' seems to be moved
libtool: install: warning: remember to run `libtool --finish /usr/lib'
libtool: install: warning: remember to run `libtool --finish /usr/lib'


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
