From: Justin Cormack <justin@street-vision.com>
Subject: Re: hdsp driver and tools update
Date: 04 Nov 2003 17:25:47 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067966747.29960.75.camel@lotte.street-vision.com>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-11-01 at 11:19, Thomas Charbonnel wrote:
> Hi,
> 
> I apologize for having been so silent the last few weeks, I was in the
> process of moving from Lyon, France to Berlin, Germany. This is now done,
> and I resumed my work on the hdsp driver and tools.
> Latest patches and tools can be found here :
> http://www.undata.org/~thomas/
> Mojor changes include support for hdsp 9632 cards and bugfixes for hdsp
> 9652 cards.
> Hdspconf and hdspmixer now support 96xx cards, though this needs testing
> as I do not have the hardware.

Thanks very much, this fixes hdsp9652 matrix mixer and it appears to be
working perfectly. hdspmixer appears to work on a quick test with 9652.
Excellent work.

(tested with todays cvs alsa).

thanks very much

Justin Cormack




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
