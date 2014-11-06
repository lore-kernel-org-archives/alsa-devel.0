From: Peter Rosin <peda@lysator.liu.se>
Subject: NXP Semiconductors TFA9879 Amplifier Driver
Date: Thu,  6 Nov 2014 13:53:59 +0100
Message-ID: <1415278441-27866-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.lysator.liu.se (mail.lysator.liu.se [130.236.254.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 790F326517F
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 13:54:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

Sorry for not sending this from my axentia.se account, but I tend to
get high spam-scores from there when I use git send-email.

This is a new driver, and it's pretty minimalistic with support for
only a few basic controls. However, it is usable and I'd be happy
to see it included.

I don't know if it's presumptious to add myself as a maintainer, but
checkpatch complained...

Are the alsa control names wisely chosen?

Please review!

Cheers,
Peter
