From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] davinci: da8xx/omap-l1xx: match codec_name
	with i2c ids
Date: Tue, 25 Jan 2011 10:36:31 -0800
Message-ID: <87fwsg25lc.fsf@ti.com>
References: <1295619896-5498-1-git-send-email-sudhakar.raj@ti.com>
	<1295620708.3348.233.camel@odin> <8739oh6h5i.fsf@ti.com>
	<87r5c15272.fsf@ti.com> <1295953146.3322.17.camel@odin>
	<20110125123529.GC13051@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog117.obsmtp.com (na3sys009aog117.obsmtp.com
	[74.125.149.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F7321039A9
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:36:38 +0100 (CET)
Received: by gwj21 with SMTP id 21so2083533gwj.41
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 10:36:36 -0800 (PST)
In-Reply-To: <20110125123529.GC13051@sirena.org.uk> (Mark Brown's message of
	"Tue, 25 Jan 2011 12:35:29 +0000")
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
Cc: davinci-linux-open-source@linux.davincidsp.com, dansharon@nanometrics.ca, alsa-devel@alsa-project.org, "Rajashekhara,
	Sudhakar" <sudhakar.raj@ti.com>, stable@kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Tue, Jan 25, 2011 at 10:59:05AM +0000, Liam Girdwood wrote:
>> On Mon, 2011-01-24 at 15:09 -0800, Kevin Hilman wrote:
>
>> > On second thought, these should probably merge for .38-rc3.
>
>> > If you're OK with it, I can merge this and the platform fix together for
>> > .38-rc3.
>
>> Yes please :)
>
> I applied it and sent it off towards Linux a few days ago.

OK, missed that.

I'll queue up the platform one then.

Thanks,

Kevin
