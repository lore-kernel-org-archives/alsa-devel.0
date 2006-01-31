From: "Eugen Bigz" <zhenja@zlo.ee>
Subject: Lost with ALSA in the beginning
Date: Tue, 31 Jan 2006 13:55:35 +0200
Message-ID: <drnik8$eo8$1@sea.gmane.org>
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
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi All,

I have ARM9 processor based board. I want to use ALSA. I have already 
created draft of driver for my audio codec.
The problem is following: I do not understand how to configure ALSA 
properly. I cannot run alsaconf utility, as this is small embedded device, 
which has only read-only file system. I try to use Dummy driver, which is 
buil into the kernel. But without success. All I can get, when using aplay 
is: Unknown PCM default.

Please point me to the place in the documentation, which tells how to 
configure ALSA manually. Thanks a lot to everyone!

Zhenja 





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
