From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH] sound/soc-core: Don't overwrite .poweroff
	in snd_soc_pm_ops
Date: Fri, 24 Feb 2012 06:57:00 -0800
Message-ID: <CAOh2x=nHZGCk6vqnKDv4Pz1c2kc=cVCXdqEZhS+AX+qGo=+9+w@mail.gmail.com>
References: <a20a22fcfed7b4e62069ef8abebfa89f557646c2.1330080832.git.viresh.kumar@st.com>
	<20120224144618.GM5450@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E6D741042B7
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 15:57:03 +0100 (CET)
Received: by wibhj6 with SMTP id hj6so1636738wib.38
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 06:57:01 -0800 (PST)
In-Reply-To: <20120224144618.GM5450@opensource.wolfsonmicro.com>
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
Cc: pratyush.anand@st.com, Viresh Kumar <viresh.kumar@st.com>, rajeev-dlh.kumar@st.com, bhavna.yadav@st.com, bhupesh.sharma@st.com, armando.visconti@st.com, alsa-devel@alsa-project.org, vipin.kumar@st.com, shiraz.hashim@st.com, amit.virdi@st.com, mirko.gardi@st.com, salvatore.dedominicis@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, lrg@ti.com, vincenzo.frascino@st.com
List-Id: alsa-devel@alsa-project.org

On Feb 24, 2012 8:16 PM, "Mark Brown" <broonie@opensource.wolfsonmicro.com>
wrote:
>
> Applied but please do try to use subject lines appropriate for the
> subsystem you're submitting against.  I'd also suggest creating a
> mailing list for ST internal people if you need to CC so many people on
> your team, the vger lists have a fairly low limit on the number of CCs
> they will accept which I think is about twenty or so, you're using a
> fair proportion of that.

What's the preferred heading for sound/soc?

We do have an internal list but we can't get mails from non st id's on
that. I will check other ways to do it.

--
Viresh
