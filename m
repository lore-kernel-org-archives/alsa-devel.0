From: VDR User <user.vdr@gmail.com>
Subject: Re: [PATCH]Support MCP89 and GT21x hdmi audio
Date: Thu, 11 Mar 2010 20:32:51 -0800
Message-ID: <a3ef07921003112032v3c3effb8n7e8f6599f4cbb453@mail.gmail.com>
References: <s5htyswpb18.wl%tiwai@suse.de> <20100308044614.GA29026@localhost>
	<a3ef07921003092142g23b93903v2b4af9c6b691bea0@mail.gmail.com>
	<alpine.LNX.2.00.1003100856420.4672@eeebox2.perex-int.cz>
	<a3ef07921003100005k6c7da149k99069cc13b3c8183@mail.gmail.com>
	<20100310125456.GA18509@localhost>
	<a3ef07921003100938o4d94161fw559bc9b563ce55b@mail.gmail.com>
	<alpine.LNX.2.00.1003110824390.4672@eeebox2.perex-int.cz>
	<a3ef07921003111015x2386cc80x73a2a4bd679b1fe1@mail.gmail.com>
	<alpine.LNX.2.00.1003111927570.4672@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 3DD982445E
	for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2010 05:32:53 +0100 (CET)
Received: by qw-out-1920.google.com with SMTP id 4so267757qwk.56
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 20:32:52 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1003111927570.4672@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Wei Ni <wni@nvidia.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <jkysela@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Pavel Hofman <pavel.hofman@insite.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 11, 2010 at 10:32 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> All these parameters should be set: CONFIG_SND_PCM_XRUN_DEBUG,
> CONFIG_SND_VERBOSE_PROCFS, CONFIG_SND_DEBUG . I updated wiki.

I have replied with both the result of my dmesg and syslog.  However,
the mailing list seems to have rejected the message due to size (62k,
but 60k is the limit).  Please let me know if you've received that
post or if I have to repost and split dmesg + syslog into two.

Thanks,
Derek
