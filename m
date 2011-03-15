From: rajeev <rajeev-dlh.kumar@st.com>
Subject: Re: Need Help For submitting A SOC drivers
Date: Tue, 15 Mar 2011 10:15:22 +0530
Message-ID: <4D7EEEE2.6040909@st.com>
References: <4D7DD83F.6040102@st.com> <20110314124311.GA23377@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog111.obsmtp.com (eu1sys200aog111.obsmtp.com
	[207.126.144.131])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BDDE103821
	for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2011 05:48:32 +0100 (CET)
In-Reply-To: <20110314124311.GA23377@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

HI mark
On 3/14/2011 6:13 PM, Mark Brown wrote:
> On Mon, Mar 14, 2011 at 02:26:31PM +0530, rajeev wrote:
> 
>> I have developed a SOC based sound card driver for a ST specific SOC and also a codec driver.
>> I wish to submit the same to mainline.
>> Please let me know the procedure for the same.
> 
> Just follow the procedure in Documentation/SubmittingPatches in the
> kernel source, same as for any other area of the kernel.  If you've got
> any more specific questions please just ask.
>
Thanks for your support
Just Wanted to know on which tree i need to do rebase before sending patches.
git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git 
or
git git://git.alsa-project.org/alsa-kernel.git 

Best Regards
Rajeev
