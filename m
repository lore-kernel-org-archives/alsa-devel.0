From: holborn <holborn@telefonica.net>
Subject: asfxload
Date: Wed, 4 Feb 2004 11:35:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402041135.40551.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi


I cant load soundfonts with asfxload .... and i can with sfxload (0.5.0)

No Emux synth hwdep device is found

and in my lsmod appears:

snd_hwdep               8448  2 snd_emu10k1
snd_emux_synth         40384  1 snd_emu10k1_synth


well the emu10k1 synths works :)

Josep



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
