From: Andrei Boros <andrei@srr.ro>
Subject: alsa-tools [CVS]
Date: Wed, 15 Oct 2003 11:38:48 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8D0798.6FA22FC4@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


gate:/serve/install/alsa-cvs/alsa-tools# ./cvscompile
configure.in:6: warning: do not use m4_patsubst: use patsubst or
m4_bpatsubst
configure.in:30: warning: do not use m4_regexp: use regexp or m4_bregexp
autoheader: `config.h.in' is unchanged
test/Makefile.am:4: `#' comment at start of rule is unportable

cvscompile gives this strange portability warning. see above.

-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
