From: Jan-Simon =?iso-8859-15?q?M=F6ller?= <dl9pf@gmx.de>
Subject: Re:
	=?iso-8859-15?q?hda-intel=3A_no_soundcard_with_curre?=
	=?iso-8859-15?q?nt_linus=27_git=09tree?=
Date: Thu, 18 Oct 2007 13:50:48 +0200
Message-ID: <200710181350.48974.dl9pf@gmx.de>
References: <471538C2.80806@m3y3r.de> <200710181049.48896.dl9pf@gmx.de>
	<s5hhcko2668.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 18A292473B
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 13:50:44 +0200 (CEST)
In-Reply-To: <s5hhcko2668.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> Well, it's not called as "working".  You did some workaround
> explicitly...
True ;) .

> > Now it doesn't work, even with other model-options (fujitsu, laptop).
>
> There is no recent change regarding Conexant codecs over months in
> ALSA tree.  So, the problem has to be there for long time.
>
> I guess you didn't take ALSA codes from alsa.git properly?  alsa.git
> master is as same as Linus tree.  The latest ALSA code is hold in mm
> branch.

Aaah ;)  switched to -mm and just compiling ...

Greets
Jan-Simon
