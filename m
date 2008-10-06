From: Brendan Pike <spike@spykes.net>
Subject: Re: Will there ever be emu20k1/x-fi support in Alsa?
Date: Sun, 5 Oct 2008 21:59:27 -0400
Message-ID: <20081005215927.3a907b59@darius>
References: <1223248483.19560.9.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 1313224340
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 03:59:28 +0200 (CEST)
In-Reply-To: <1223248483.19560.9.camel@home>
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
List-Id: alsa-devel@alsa-project.org

On Sun, 05 Oct 2008 18:14:43 -0500
"Ted T. Logian" <tedtheologian@gmail.com> wrote:

> I had to ask because oss4 has had emu20k1/x-fi support for a long time
> now.  However, it has the obvious limitations of oss4 and also you
> cannot use usb microphones, so I can't use skype which I'd really like
> to do.
> 
> Any ideas? 

Yes, just pay James Courtier-Dutton a lot of money to write a driver. If
you're in the EMU or X-Fi camp, you should of moved on by now. Creative
are providing NDA'd specs to the wrong person at ALSA. (See EMU
0202/0404, and now X-Fi support)

Don't bother contacting him either, it goes straight to /dev/null.

Bottom line, if one can't write a driver or don't have time, don't
bother to NDA specifications okay? It just slows things down.

Furthermore Creative isn't going to pay someone to write a driver, so
its not going to happen for a very long time, unless they decide to
open the specs and stop the NDA junk.

Nobody with know-how has bothered to port the partially working oss4
driver to ALSA, so interest is quite low.
