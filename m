From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v7 1/3] ASoC: da7210: Add support for DAPM
Date: Fri, 21 Oct 2011 16:31:53 +0530
Message-ID: <1319194913.24621.193.camel@matrix>
References: <1319119369.24621.84.camel@matrix>
	<20111021085838.GE3513@opensource.wolfsonmicro.com>
	<1319193441.24621.170.camel@matrix>
	<20111021103149.GC4080@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D1AE10388C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 12:53:08 +0200 (CEST)
In-Reply-To: <20111021103149.GC4080@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-21 at 11:31 +0100, Mark Brown wrote:
> On Fri, Oct 21, 2011 at 04:07:21PM +0530, Ashish Chavan wrote:
> 
> > Is there web interface to your tree? so that I can introspect your
> > version of da7210.c file to find out what is going wrong? Or any other
> > way to get your version of that file?
> 
> http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi
> 

Thanks. Got the issue. Resubmitting the patch shortly.
