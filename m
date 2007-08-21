From: Rolland Dudemaine <rolland@ghs.com>
Subject: include/mixer.h missing from doxygen
Date: Tue, 21 Aug 2007 16:07:45 +0200
Message-ID: <46CAF1B1.2070908@ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2f.orange.fr (smtp2f.orange.fr [80.12.242.152])
	by alsa0.perex.cz (Postfix) with ESMTP id F060F103891
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 16:07:52 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 37A2C70000AA
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 16:07:52 +0200 (CEST)
Received: from [127.0.0.1] (ASt-Lambert-152-1-78-228.w86-217.abo.wanadoo.fr
	[86.217.68.228])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 0651F70000A6
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Aug 2007 16:07:51 +0200 (CEST)
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

Hi,

include/mixer.h seems to be missing from the doxygen input file list.
Should be added to the INPUT list in doc/doxygen.cfg.

Btw, I'm pretty new do ALSA, why is the Mixer interface marked legacy in a 
couple places ?

Best Regards,
--Rolland Dudemaine
