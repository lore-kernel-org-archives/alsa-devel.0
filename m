From: "Michel Benoit" <murpme@gmail.com>
Subject: alsa driver api
Date: Wed, 2 May 2007 19:40:29 +0200
Message-ID: <c88e466f0705021040p1166b247t864288e3355dc25c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 5076224451
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 19:40:31 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so209954nzf
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2007 10:40:30 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ciacciax@yahoo.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

Does anyone have some code examples that show how to send pcm samples
directly to an alsa driver.  I'm (still) having trouble building/using
alsa-lib and I want to make sure that my driver works correctly. If I
understand correctly it is possible to send sound samples using the
alsa driver api only (no alsa-lib).

All I want to do for now is send a fixed sine wave to the driver. I
saw some code snippets that seemed to do just that in a recent email
on this list but it would help a lot if I could have a look at the
complete application.

Thanks,

Michel
