From: Justin Cormack <justin@street-vision.com>
Subject: Re: HDSP + multiface "freezing" patch
Date: 07 Mar 2003 14:18:30 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047046715.3003.27.camel@lotte>
References: <200303071403.h27E30515698@tench.street-vision.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303071403.h27E30515698@tench.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Charbonnel <thomas@undata.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2003-03-07 at 14:08, Paul Davis wrote:
> >> We were searching a vicious bug, but it was a trivial one...
> >> Applies on top of Paul's patch version II.
> >> 
> >> Thomas
> >>
> >
> >ok, I am trying to test Paul's patch on the HDSP9652, but I cant get it
> >to play anything. I applied it to 0.9.0rc8b, but aplay just returns
> 
> which PCM device are you using?

plughw:0,0

(hw:0,0 gives the same error though. It should play 26 channels shouldnt
it)





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
