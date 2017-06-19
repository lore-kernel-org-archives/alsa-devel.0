From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 2/7] ASoC: stm32: change SAI configuration
	flag
Date: Mon, 19 Jun 2017 08:51:15 +0000
Message-ID: <dfa236b4-4561-25c2-fba8-9564f6c837c0@st.com>
References: <1497615334-7156-1-git-send-email-olivier.moysan@st.com>
 <1497615334-7156-3-git-send-email-olivier.moysan@st.com>
 <20170616174915.olqfpqrszku3eguu@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id BA396266851
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 10:51:18 +0200 (CEST)
In-Reply-To: <20170616174915.olqfpqrszku3eguu@sirena.org.uk>
Content-Language: en-US
Content-ID: <8BADBA991EA85C41A55AF17AD22DF4F9@st.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 06/16/2017 07:49 PM, Mark Brown wrote:
> On Fri, Jun 16, 2017 at 02:15:29PM +0200, olivier moysan wrote:
>> Use a specific flag for SAI interface instead
>> of common stm32 asoc flag.
> 
> This doesn't apply against current code, please check and resend.
> 

I pushed this patch-set on stm topic branch.
I resend a patch on next, to fix the merge issue.

Best regards
olivier
