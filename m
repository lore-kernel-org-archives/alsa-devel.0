From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v2] wm8940: remove unnecessary if statements
Date: Tue, 7 Jun 2011 09:33:04 +0100
Message-ID: <4DEDE240.3080009@ti.com>
References: <4DECA33E.5040306@ti.com>
	<1307393581-25202-1-git-send-email-Gregory.Dietsche@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id AFE3524395
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:33:08 +0200 (CEST)
In-Reply-To: <1307393581-25202-1-git-send-email-Gregory.Dietsche@cuw.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: "dp@opensource.wolfsonmicro.com" <dp@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>
List-Id: alsa-devel@alsa-project.org

On 06/06/11 21:53, Greg Dietsche wrote:
> removing unnecessary if(ret) checks
> 
> This updated patch corrects a minor spelling problem in the commit message
> and resolves two other (similar) issues found in wm8940.c by Jonathan Cameron.
> 
> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>

Acked-by: Liam Girdwood <lrg@ti.com>
