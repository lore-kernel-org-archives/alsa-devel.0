From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: PC speaker beeps in 2.6.30?
Date: Fri, 26 Jun 2009 10:03:54 +0400
Message-ID: <4A4464CA.4060006__40388.8632696637$1245997408$gmane$org@msgid.tls.msk.ru>
References: <4A365DA6.8000102@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A365DA6.8000102@msgid.tls.msk.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

[Adding some more Cc's...]

Am I the only concerned about this?  My 2.6.30 is still
silent w.r.t. old good PC speaker beeps, and I wasn't
able to make it to produce any sound.  Yes, as pointed
out by others there is a control now, in alsa, and I
can hear ugly and scary beeps from my stereo speakers
(when they're turned on and when the control is un-muted).
But that's.. not a solution/answer to the original
question... ;)

Thanks!

Michael Tokarev wrote at Mon, 15 Jun 2009 18:41:42 +0400:
> Anyone know what happened with PC speaker in 2.6.30?
> Basically, it does not work anymore here, with the
> config which is very similar to the one used for
> previous 2.6.29 kernel (where PC speaker worked).
> At least I don't see any relevant differences and
> the (seemengly) relevant symbols -- which are
> INPUT_PCSPKR and PCSPKR_PLATFORM -- are both set
> to 'y' for both 2.6.29 and 2.6.30.
> 
> Help? :)
> 
> Thanks.
> 
> /mjt

