From: Lars Schotte <lars.schotte@schotteweb.de>
Subject: CA0106
Date: Thu, 1 Apr 2010 16:31:31 +0200
Message-ID: <20100401163131.65905315@romy.gusto>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms16-1.1blu.de (ms16-1.1blu.de [89.202.0.34])
	by alsa0.perex.cz (Postfix) with ESMTP id BC8BC2414C
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Apr 2010 16:31:38 +0200 (CEST)
Received: from [78.99.186.124] (helo=romy.gusto)
	by ms16-1.1blu.de with esmtpsa (TLS-1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69) (envelope-from <lars.schotte@schotteweb.de>)
	id 1NxLQj-0008FV-LQ
	for alsa-devel@alsa-project.org; Thu, 01 Apr 2010 16:31:33 +0200
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

hi,
Clemens wrote that "
The CA0106 is supported, and
> used on several cheap Sound Blaster cards, e.g. the SB 5.1 VX
"
CA0106 is supported, but I looked at the website and there is:
http://www.alsa-project.org/main/index.php/Matrix:Vendor-Creative_Labs
CA0106
	Details 	[PCI] Digital/Analog input does not work yet.
	Needs more development work. 

so ... that seems like line in doesnt work yet, but on the unofficial
http://alsa.opensrc.org/index.php/Ca0106
is "
Capture from MIC an LINE IN input. 
"
so looks like that already works, but maybe recently.

that could be relevant to me as far as not buy a VX when I want to make
it work on debian stable w/o changes, but however, I could install the
git version or a snapshot. its just not clear all.
-- 
-------------------
Lars Schotte @ romy
