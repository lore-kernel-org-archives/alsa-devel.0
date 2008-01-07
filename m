From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: python midi wrapper
Date: Mon, 7 Jan 2008 12:02:32 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801071200130.22730@tm8103.perex-int.cz>
References: <17eedd8a0801041001m3810fac6q945d2ba551e15a17@mail.gmail.com>
	<s5hk5mlaopp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C3E972488B
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 12:02:32 +0100 (CET)
In-Reply-To: <s5hk5mlaopp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Aldrin Martoq <amartoq@dcc.uchile.cl>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Jan 2008, Takashi Iwai wrote:

> At Fri, 4 Jan 2008 15:01:39 -0300,
> Aldrin Martoq wrote:

> > I have tried to contact the mantainer of PyAlsaAudio (cwi@unispeed.dk
> > from the README file) for merging my code in his project, but have not
> > received a response so far and the date of files seems old.
> > 
> > Is anybody here interested in the merge? How can I put this effor in
> > python-alsaaudio or may I create a new project for this specific task?
> > Is the pyalsa project related to pyalsaaudio?
> 
> So far, pyalsaaudio is an independent project.
> I've not checked the pyalsaaudio codes yet, but if it's worth to
> merge, it'd be surely possible to create a repo...

I maintain official ALSA pyalsa package. If you port / create a sequencer 
binding to this tree, I'm sure we can commit it there.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
