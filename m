From: "Denis, jMarc" <jm@ilfesprit.fr>
Subject: hecking for libasound headers version
Date: Mon, 21 Jul 2003 14:41:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <DFEEJKMCBANHCIJNKLLGMEOOCFAA.jm@ilfesprit.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi, 
I have installed : alsa-driver, alsa-lib, alsa-utils.
When i try to compile alsa-oss-0.9.4 i have this problem :

" checking for libasound headers version >= 0.9.0... not present.
configure: error: Sufficiently new version of libasound not found. "

But : 
[root@localhost alsa-oss-0.9.4]# locate libasound
/usr/lib/libasound.so
/usr/lib/libasound.so.2
/usr/lib/libasound.so.2.0.0

Anyone have an idea ?

____

Best regards, 
Denis jeanMarc 
SysAdmin


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
