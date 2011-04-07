From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH] sst: fix compile error
Date: Thu, 7 Apr 2011 16:00:53 +0800
Message-ID: <20110407080053.GD8484@qtel.sh.intel.com>
References: <20110407021813.5372.82489.stgit@localhost>
	<20110407062717.GA14519@opensource.wolfsonmicro.com>
	<20110407064420.GC8484@qtel.sh.intel.com>
	<20110407075031.GD14519@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 391CA103854
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 10:01:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110407075031.GD14519@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA <alsa-devel@alsa-project.org>, "gregkh@suse.de`" <gregkh@suse.de>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 03:50:31PM +0800, Mark Brown wrote:
> On Thu, Apr 07, 2011 at 02:44:20PM +0800, Lu Guanqun wrote:
> 
> > This compile error is actually caused by my fault, see below commit.
> 
> Ah, OK, it's a change I've applied in my tree that introduces the issue
> - I'll apply your fix next time I run through patches.

Thanks. Later when I'm sending patches, I'll try to clarify which kernel
tree I'm based on...

-- 
guanqun
