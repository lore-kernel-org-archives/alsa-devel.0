From: Fred Jan Kraan <fjkraan@xs4all.nl>
Subject: ALSA driver architecture documentation?
Date: Mon, 19 Aug 2002 21:37:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020819213712.A18500@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Recently I started to collect some info on how to make a ALSA driver for
the Digigram VXpocket V2. Digigram decided to provide information
this PCMCIA card, on condition that a moderator is the single point of
contact with Digigram.
A driver for the VXpocket should interface with the PCMCIA module and
(most likely) the ALSA package. Info on how to make a PCMCIA driver
easy to find. Description of layers and a well documented dummy driver.
Alas I did not find much info in the ALSA structure. There is lots of
source code and even a dummy driver, but completely uncommented.
What seems to be documented is how to interface with ALSA, not how to
write a ALSA driver. So is there more than "use the source"? :-)


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
