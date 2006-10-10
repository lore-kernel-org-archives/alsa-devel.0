From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 0/8] ASoC pxa2xx support
Date: Tue, 10 Oct 2006 17:11:24 +0100
Message-ID: <1160496684.24436.108.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Nicolas Pitre <nico@cam.org>
List-Id: alsa-devel@alsa-project.org

This patch series adds ASoC platform support (AC97 & I2S) for the Marvel
(was Intel) pxa2xx (XScale) CPU's (excludes Monahans atm). 

This series also adds alsa support for some of the Sharp Zaurus PDA
family (Corgi, Tosa, Poodle and Spitz/Akita).

I've left out the SSP audio support atm as there are still a couple of
issues I'd like to fix before submission.

Liam 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
