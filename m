From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] wm8940: remove unnecessary if statements
Date: Tue, 7 Jun 2011 09:48:49 +0100
Message-ID: <20110607084845.GA18544@opensource.wolfsonmicro.com>
References: <4DECA33E.5040306@ti.com>
	<1307393581-25202-1-git-send-email-Gregory.Dietsche@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6C0DF24399
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:48:52 +0200 (CEST)
Content-Disposition: inline
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, tiwai@suse.de, jic23@cam.ac.uk, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2011 at 03:53:01PM -0500, Greg Dietsche wrote:
> removing unnecessary if(ret) checks
> 
> This updated patch corrects a minor spelling problem in the commit message
> and resolves two other (similar) issues found in wm8940.c by Jonathan Cameron.

Applied, thanks.
