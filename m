From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v1 00/15] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Thu, 4 Jan 2018 11:50:24 -0800
Message-ID: <CAG5mAdwDo0RV59HDgXNj3rGwBbu_RuGjTVPifWALmsq27ADz5Q@mail.gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
 <CAG5mAdxBOvrE3U-PAZVKepZfTZc91kKOLrC_UoMnBsoZvJ9hyA@mail.gmail.com>
 <20180104194842.GE27975@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f48.google.com (mail-pl0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9973A267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 20:50:48 +0100 (CET)
Received: by mail-pl0-f48.google.com with SMTP id 62so1629434pld.7
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 11:50:48 -0800 (PST)
In-Reply-To: <20180104194842.GE27975@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de, Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 4, 2018 at 11:48 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Tue, Jan 02, 2018 at 03:28:11PM -0800, Caleb Crome wrote:
>
>> tested this patch set on MX6 SSI against broonie for-next (4.15-rc5),
>> no problems.
>> Do I send a separate Tested-by for each patch, or just the 00/15 one?
>
>> Tested-by: Caleb Crome <caleb@crome.org>
>
> I will include your Tested-by to each patch in v2 unless there is
> going to be a critical change suggested by the future reviews so
> that we need another round of full testing. Thank you

Great.

-Caleb
