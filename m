From: Thorsten Leemhuis <fedora@leemhuis.info>
Subject: alsa-oss devel-files and alsa-firmware license
Date: Thu, 11 Dec 2003 13:59:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071147572.4567.56.camel@thl.ct.heise.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I'm currently repacking alsa for the fedora.us repository.

I have two problems at the moment:

- I can't find any license info in the alsa-firmware package. Is it
freely redistributable? An if, under which license?  
Current fedora.us bug:
http://bugzilla.fedora.us/show_bug.cgi?id=1107

- What the purpose of
/usr/lib/libaoss.a
/usr/lib/libaoss.so
after compiling alsa-oss? Nobody should be compiling with them,
or missed I something? Maybe see bug

http://bugzilla.fedora.us/show_bug.cgi?id=592

for a better description of our current problem. I'm not enough a C
developer and also don't know alsa so deep...

Thanks for your help 

CU
Thorsten Leemhuis



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
