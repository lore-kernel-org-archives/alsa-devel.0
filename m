From: Oliver Bestmann <7bestman@informatik.uni-hamburg.de>
Subject: no support for docking station with acl259?
Date: Wed, 24 Nov 2010 17:13:40 +0100
Message-ID: <20101124171340.e9926e33.7bestman@informatik.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id CE182243FF
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 17:13:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id A4AC882D
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 17:13:50 +0100 (CET)
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
	by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1])
	(amavisd-new, port 10024)
	with LMTP id jWyDDpBb0mu8 for <alsa-devel@alsa-project.org>;
	Wed, 24 Nov 2010 17:13:50 +0100 (CET)
Received: from laptop (port-12030.pppoe.wtnet.de [84.46.47.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: 7bestman)
	by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id
	EC82882C
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2010 17:13:49 +0100 (CET)
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

hey,

i have an hda-intel card with an acl259 chipset. everything works fine
except the in and output jacks on the docking station. they arent
recognized by alsa and the dont show up in alsamixer. i'm jusing the
drivers from the current kernel 2.6.37-rc3.
i'd like to provide every necassary information to help someone to fix
this problem or, if someone could tell me how, i'd try fixing it myself.

cheers,
olli


-- 
Oliver Bestmann <7bestman@informatik.uni-hamburg.de>
