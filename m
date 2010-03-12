From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Fri, 12 Mar 2010 12:37:02 +0800
Message-ID: <20100312043702.GA30428@localhost>
References: <20100308044614.GA29026@localhost>
	<a3ef07921003092142g23b93903v2b4af9c6b691bea0@mail.gmail.com>
	<alpine.LNX.2.00.1003100856420.4672@eeebox2.perex-int.cz>
	<a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>
	<20100310125456.GA18509@localhost>
	<a3ef07921003100938o4d94161fw559bc9b563ce55b@mail.gmail.com>
	<alpine.LNX.2.00.1003110824390.4672@eeebox2.perex-int.cz>
	<a3ef07921003111015x2386cc80x73a2a4bd679b1fe1@mail.gmail.com>
	<alpine.LNX.2.00.1003111927570.4672@eeebox2.perex-int.cz>
	<a3ef07921003112032v3c3effb8n7e8f6599f4cbb453@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id C657624466
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 05:37:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a3ef07921003112032v3c3effb8n7e8f6599f4cbb453@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: Wei Ni <wni@nvidia.com>, alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <jkysela@redhat.com>, akpm <akpm@linux-foundation.org>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 12, 2010 at 12:32:51PM +0800, VDR User wrote:
> On Thu, Mar 11, 2010 at 10:32 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> > All these parameters should be set: CONFIG_SND_PCM_XRUN_DEBUG,
> > CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG . I updated wiki.
> 
> I have replied with both the result of my dmesg and syslog.  However,
> the mailing list seems to have rejected the message due to size (62k,
> but 60k is the limit).  Please let me know if you've received that
> post or if I have to repost and split dmesg + syslog into two.

Never mind, the CC'ed users should be able to receive it.

Thanks,
Fengguang
