From: randall <lists_rlr@roadrunner.com>
Subject: snd-hda-intel module now working
Date: Wed, 18 Jun 2008 17:02:25 -0700
Message-ID: <200806181702.25848.lists_rlr@roadrunner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta15.adelphia.net (mta15.mail.adelphia.net [68.168.78.77])
	by alsa0.perex.cz (Postfix) with ESMTP id 8253C1037EC
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 02:02:28 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

After rebuilding the kernel about 5 times and double-checking the KMixer 
controls, I have finally successfully been able to get the onboard sound 
working.  Took 2 days tweaking and rebuilding the kernel.

I used the "3stack-6ch-dig" setting for the model and turned on a SND debug 
variable.

- Randall
