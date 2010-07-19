From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] asoc: davinci: let platform data define edma queue numbers
Date: Mon, 19 Jul 2010 12:35:54 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7BD3A68@dbde02.ent.ti.com>
References: <1279196059-6031-1-git-send-email-nsekhar@ti.com>
	<20100717185018.GC27456@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20100717185018.GC27456-HF5t3jzXg/6ND3a5+9QAFujbO/Zr0HzV@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sun, Jul 18, 2010 at 00:20:19, Mark Brown wrote:
> On Thu, Jul 15, 2010 at 05:44:19PM +0530, Sekhar Nori wrote:
>
> > This patch has been tested on DM644x and OMAP-L138 EVMs.
>
> > Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>
> > This patch applies to latest of Linus's tree.
>
> ...so it doesn't apply against my for-2.6.36 branch (and obviously
> there's crossover with Kevin's tree as well which makes things possibly
> a bit interesting too).  Could you please regenerate against for-2.6.36?
> You should generally always send patches against the latest version of
> code rather than Linus' tree, using other trees increases the chances
> that your patch will not apply.

Thanks for the feedback. I rebased against for-2.6.36 and sent a v2.

Regards,
Sekhar
