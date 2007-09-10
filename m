From: ricman <the_ricman@yahoo.com>
Subject: RME HDSPe Info/Question
Date: Mon, 10 Sep 2007 04:56:07 -0700 (PDT)
Message-ID: <661342.2248.qm@web62001.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web62001.mail.re1.yahoo.com (web62001.mail.re1.yahoo.com
	[69.147.74.224]) by alsa0.perex.cz (Postfix) with SMTP id E377D243BE
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 13:56:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Howdy!

I would like to share a piece of information which I am hoping will
be helpful to the ALSA development community.  This information is
regarding the RME HDSP Multiface/Digiface family of products.  We
know from

  http://www.alsa-project.org/main/index.php/Matrix:Vendor-RME

and

  http://www.alsa-project.org/main/index.php/Matrix:Module-hdsp

that we have a PCI driver for Linux thanks to Paul Davis, Marcus
Andersson, Thomas Charbonnel (and probably others).  However, RME
recently came out with a new PCI Express (PCI-E) interface for
these products.

Here is where is gets interesting: I've been trying to ascertain
whether I should purchase the PCI-E HDSPe card for my Linux box.
I prayed to the RME gods on their forum and none other than
Matthias Carstens of RME responded that

  "The PCIe cards are fully downward compatible, so can be used
   even with the oldest Windows drivers. So I expect Linux to
   work with them too."
   (http://www.rme-audio.de/forum/viewtopic.php?id=1031)

Is it possible that he is right?  Will the old PCI Linux driver
work just the same (or better) with the newer PCI-E card?  For
some reason I just naturally thought the PCI-E card would need
its own special driver.

Or is the only way to know to just buy and see if it works?  That
seem like an expensive way to find out...

Thanks!



       
____________________________________________________________________________________
Choose the right car based on your needs.  Check out Yahoo! Autos new Car Finder tool.
http://autos.yahoo.com/carfinder/
