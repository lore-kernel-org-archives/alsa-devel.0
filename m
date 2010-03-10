From: maximilian attems <max@stro.at>
Subject: Bug#573243: Front Mic Boost mixer control missing on 2.6.33
Date: Wed, 10 Mar 2010 03:30:52 +0100
Message-ID: <20100310023052.GU7231@baikonur.stro.at>
References: <20100310015828.15599.86090.reportbug@Heisenberg.home>
Reply-To: maximilian attems <max@stro.at>, 573243@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.573243.B573243.126819057216970@bugs.debian.org>
Content-Disposition: inline
In-Reply-To: <20100310015828.15599.86090.reportbug@Heisenberg.home>
List-URL: <http://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
To: Anthony DeRobertis <anthony@derobert.net>, 573243@bugs.debian.org
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 09, 2010 at 08:58:28PM -0500, Anthony DeRobertis wrote:
> Package: linux-2.6
> Version: 2.6.33-1~experimental.2
> Severity: normal
> 
> This is an Asus UL30A.
> 
> On 2.6.32, I get two Mic Boosts: One called "Mic Boost" and one called
> "Front Mic Boost". The "Front Mic Boost" is for the built-in microphone
> mounted at the top of the display; the other is assumably the mic input
> jack (have not tested).
> 
> On 2.6.33, the Front Mic Boost goes away, making the built-in mic
> unusable.
> 
> Attached is the output of "amixer contents" on 2.6.33. Please let me
> know if you need one from 2.6.32.
> 

please sent output of alsa-info.sh of 2.6.32 and 2.6.33

thanks
