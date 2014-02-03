From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 4/4] ASoC: davinci-mcasp: Code cleanup in
	davinci_mcasp_hw_params()
Date: Mon, 3 Feb 2014 14:47:17 +0200
Message-ID: <52EF8FD5.1060106@ti.com>
References: <1391087725-4088-1-git-send-email-peter.ujfalusi@ti.com>
 <1391087725-4088-5-git-send-email-peter.ujfalusi@ti.com>
 <20140131161153.GL22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 3DEE2260824
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 13:47:22 +0100 (CET)
In-Reply-To: <20140131161153.GL22609@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 01/31/2014 06:11 PM, Mark Brown wrote:
> On Thu, Jan 30, 2014 at 03:15:25PM +0200, Peter Ujfalusi wrote:
>> Rearrange the code in the function for readability.
> =

> This doesn't apply cleanly on my topic/davinci, presumably because of
> Jiri's recent work though I didn't look too hard.  Can you please check
> and resend?

Yes, I will. While I'm at this I will add two more cleanup patches.

-- =

P=E9ter
