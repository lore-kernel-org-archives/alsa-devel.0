From: Gary Jones <nddesigns@gmail.com>
Subject: Thanks to Peter Zubaj's patch.
Date: Fri, 1 Apr 2005 03:58:46 -0500
Message-ID: <200504010358.48343.nightbreed@verizon.net>
Reply-To: nightbreed@verizon.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

With my issue to the missing Line 2 and Aux 2 problem for my Audigy 1 card. I 
added Peter Zubaj's part of the patch which was the  '.ac97_chip =1' to the 
"Audigy 1 or 2 [Unkown]" in emu10k1_main.c file and recompiled. After which 
all ins and outs showed up again.

Thanks for the patch Peter.


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
