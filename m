From: Mark Constable <markc@renta.net>
Subject: Re: alsa-conf will not compile.
Date: Tue, 25 Jun 2002 16:05:22 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D180822.2080008@renta.net>
References: <3D17B909.20006@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Has anyone managed to get "alsa-conf" to compile ?

Yes, just now after seeing your message. I was missing
/usr/inlcude/slang.h but once I installed the package
with that header it went thru Ok.

> I use the current CVS, but it will not compile.

You neglected to paste some info about why you compile
did not work. We need to see the errors.

 > Is "alsa-conf" of any use any more ?

I would imagine it would not be in CVS if it was no
longer of any use.

--markc




-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
