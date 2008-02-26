From: Karl Grill <kgrill@chello.at>
Subject: hdsp firmware
Date: Tue, 26 Feb 2008 21:58:44 +0100
Message-ID: <47C47D84.3000804@chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep32-int.chello.at (viefep32-int.chello.at [62.179.121.50])
	by alsa0.perex.cz (Postfix) with ESMTP id B17E61037F5
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 21:52:50 +0100 (CET)
Received: from [84.112.6.110] by viefep32-int.chello.at
	(InterMail vM.7.08.02.02 201-2186-121-104-20070414) with ESMTP
	id <20080226205249.HYHL5396.viefep32-int.chello.at@[84.112.6.110]>
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 21:52:49 +0100
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

Hi all,
as a first step towards implementing support for the hdsp rpm, I've
uploaded a patch to the alsa-firmware branch as bug report #3810. 
Besides the patch, I've put up the firmware binaries in .tar.gz format.
This contains replacements for the rev.11 firmware for the 
digiface/multiface and also for the rpm. The latter is of little use 
right now, but I'd be very happy if anybody could try those for the 
digiface/multiface and report if it works, so I know if my assumptions 
on the drivers are correct.

best regards
kg

PS. sorry I didn't file this report in the firmware section, but the web 
form there doesn't give me any usable choice for Category yet insists 
that I supply one.
