From: bart@etpmod.phys.tue.nl
Subject: cmedia 8378 capture/playback not working (well) in CVS
Date: Mon, 11 Feb 2002 14:05:32 +0100 (CET)
Message-ID: <200202111305.g1BD5Z807890@gum09.etpnet.phys.tue.nl>
Reply-To: bart@etpmod.phys.tue.nl
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa developer mailinglist <alsa-devel@alsa.alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi All!

My cmedia 8378-MC6 only captures silence when doing 16 bits samples from
both line-in and aux with current (2/10) CVS. 8 bits capture seems to
work, but is very noisy.

In addition, during playback using aplay, I hear the last part of a
wav-file twice. 

I am more than willing to take a good look at the cmipci driver, but I
haven't been able to find (as usual) any datasheets. Only some useless
crap at the cmedia.com.tw web-site. Does anyone have any REAL
datasheets?

TIA,
Bart

-- 
Bart Hartgers - TUE Eindhoven 
Get my GPG key at http://etpmod.phys.tue.nl/bart/pubkey.gpg 


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
