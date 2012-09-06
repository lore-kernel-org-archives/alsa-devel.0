From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH -next] soc: fix wm0010.c printk format
	warning
Date: Thu, 6 Sep 2012 08:06:13 +0800
Message-ID: <20120906000612.GO10580@opensource.wolfsonmicro.com>
References: <20120905161230.3bab1de6d4c8c8e466c3b0df@canb.auug.org.au>
 <5047DF49.6070502@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6E7B0264EAA
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 02:06:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5047DF49.6070502@xenotime.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 05, 2012 at 04:24:57PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix printk format warning:

Somone already sent this.  As ever please try to use subject lines
appropriate for the subsystem.  Please also consider who you're CCing -
there's no need to copy -next on things like this which aren't
integration issues for example, if we start doing that then it'd get
drowned in noise from all the development.
