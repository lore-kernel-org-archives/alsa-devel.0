From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: Calls from a custom dynamic shared library call the wrong version of alsa functions in libasound
Date: Thu, 11 Aug 2005 16:04:30 +0200
Message-ID: <m2iryck1sh.fsf@vador.mandriva.com>
References: <42FAB657.2070307@thehoytfamily.com>
	<1123727292.30766.0.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123727292.30766.0.camel@mindpipe> (Lee Revell's message of
	"Wed, 10 Aug 2005 22:28:11 -0400")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Coder <linux@thehoytfamily.com>, Alsa Developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell <rlrevell@joe-job.com> writes:

> Well, you must have multiple ALSA version installed.  What does ldd
> your_app say?

the major of the alsa lib hasn't changed for years, so i doubt one can
actually have several versions of this lib installed...



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
