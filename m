From: Amaury Jacquot <sxpert@esitcom.org>
Subject: experience with Creative MP3+ usb
Date: Sat, 13 Dec 2003 20:12:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FDB64A9.7060009@esitcom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
I am using a Creative Labs MP3+ usb sound device.
mobo is VIA EPIA 800, USB is UHCI
Alsa is 1.0rc2

The things works great, it's not even muted on startup (huh ?)
I am running a home built music player using gstreamer 0.7.2 (source 
available on request). Using the oss emulation layer

now, for the issues.
everytime I close the sound device, I get the following

"usb_control/bulk_msg: timeout"

any has an explanation ?
can it be avoided ?

sincerely
Amaury



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
