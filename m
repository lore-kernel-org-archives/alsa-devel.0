From: Albrecht <ag-linux@4usgass.net>
Subject: Problem w/ VIA 8235 card and Mandrake 9.2
Date: Wed, 26 Nov 2003 18:11:36 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069870296.3fc4ecd835b73@www.4usgass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
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

Hey,

I have had no luck getting my VIA8235 based sound card that is connected via an
optical link to my receiver to work under Mandrake 9.2.
The configuration looks ok as far as I can tell and I get no errors from
alsamixer, alsactl, aplay, and other sound utilities but no sound.
Interestingly enough the program rcalsasound seems to be missing that is used by
the configuration tool but it still seems to do the config ok.

So my first question is has anybody gotten the via8235 to work w/ the optical link?

If yes, what should I do next? I already downloaded alsa-driver-0.9.8 and
compiled and installed but no the snd module complains about anresolved symbols. 
Which source packages do I need to download so that I can use the latest drivers?

Thanks
Albrecht


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
