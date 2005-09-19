From: peter plessas <plessas@mur.at>
Subject: hdspmixer defaults
Date: Mon, 19 Sep 2005 23:03:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0509192300420.25606@hornet.mur.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

Dear List,

i have the following question about hdspmixer:

1.
After booting, i have to start the hdspmixer application to get audio 
output, i suppose the levels are muted before.
Is this an hdspmixer issue or sth. about the alsa startup scripts?

2.
If i close the hdspmixer and open it again, it loads the default settings 
(if there are any) and thus gives me full levels on all channels. Ouch!
This also happens if i saved my levels to a preset, may it be number 1 or 
others.
It even persists at saving to a file (/home/peter/hdspmixer_default.mix), 
and making this the default file via the menu.
Seems like the file doesn't get loaded automatically, though once loaded 
via the menu, my old levels appear.

Any ideas are very welcome!!

Peter


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
